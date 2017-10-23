#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# Copyright (C) 2017  zonkylla Contributors see COPYING for license

'''Database module'''

import logging
import sqlite3
import sys
import yaml

DB_VERSION = 2


class Database:
    '''Connection with sqlite3 database'''

    def __init__(self):
        '''Init the connection'''

        self.logger = logging.getLogger('zonkylla.Abstract.Database')
        self.database = './zonkylla.db'
        self.connection = sqlite3.connect(self.database)

        with open('./data/tables.yaml', 'r') as stream:
            self.schema = yaml.load(stream)

        self._create()

        self._check_db_version()

        self._clear_table('a_wallet')
        self._clear_table('a_blocked_amounts')

    def _convert_value(self, table, key, value):
        '''Convert value due to database schema'''

        def convert_bool(value):
            '''Convert bool to str'''

            if 'true' in str(value).lower():
                value = 1
            elif 'false' in str(value).lower():
                value = 0
            elif int(value) == 1:
                value = 1
            elif int(value) == 0:
                value = 0

            return value
            # end of function

        if value is None:
            return None

        value_type = self.schema[table]['columns'][key]

        value_convertion = {
            'text': str,
            'int': int,
            'real': float,
            'bool': convert_bool,
            'datetime': (lambda v: v),
        }

        try:
            return value_convertion[value_type](value)
        except:
            raise TypeError(table, key, value)

    def _create_sql_cmd(self, table):
        '''Return create SQL command'''

        cmd = 'CREATE TABLE IF NOT EXISTS {} (\n'.format(table)
        items = []

        for column_name, column_type in self.schema[table]['columns'].items():

            col_type = column_type.upper()
            if column_type == 'bool':
                col_type = 'INT'

            is_primary_key = self.schema[table]['primary_key']['name'] == column_name
            is_autoincrement = self.schema[table]['primary_key']['autoincrement']

            aug_col_type = 'INTEGER PRIMARY KEY' if is_primary_key else col_type
            aug_col_type += ' {}'.format(self.schema[table]['primary_key']
                                         ['order'].upper()) if is_primary_key else ''
            aug_col_type += ' AUTOINCREMENT' if is_primary_key and is_autoincrement else ''

            items += ['{} {}'.format(column_name, aug_col_type)]

        cmd += '\t' + ',\n\t'.join(items) + '\n)'

        return cmd

    def _create(self):
        '''Prepare the structure if doesn't exist'''

        sql_commands = []
        for table in self.schema:
            sql_commands.append(self._create_sql_cmd(table))

        for sql_command in sql_commands:
            self.execute(sql_command)

    def _clear_table(self, table):
        sql_command = 'DELETE FROM {}'.format(table)
        self.execute(sql_command)

    def _check_db_version(self):

        sql = 'SELECT MAX(db_version) AS mdb_version FROM z_internals'
        res = self.execute(sql).fetchone()

        if not res['mdb_version']:
            sql = 'INSERT INTO z_internals (db_version) VALUES (?)'
            self.execute(sql, [(DB_VERSION)])
            return

        if res['mdb_version'] != DB_VERSION:
            self.logger.error(
                "Old version of database scheme, remove file '%s', please.",
                self.database)
            sys.exit(1)

    def execute(self, sql, data=None):
        """Executes SQL query with or without data"""
        if data is None:
            many = False
        elif isinstance(data, list):
            many = bool(all(isinstance(member, (tuple, list))
                            for member in data))
        else:
            raise TypeError

        try:
            with self.connection as con:
                con.row_factory = sqlite3.Row
                con = con.cursor()
                self.logger.debug("Executing '%s'", sql)
                if many:
                    self.logger.debug("with many data: '%s'", data)
                    result = con.executemany(sql, data)
                else:
                    if data:
                        self.logger.debug("with data: '%s'", data)
                        result = con.execute(sql, data)
                    else:
                        result = con.execute(sql)
            return result

        except sqlite3.Error as err:
            print("sqlite3.Error occured: {}".format(err.args))
            raise

    def insert_or_update(self, table, data):
        '''Common insert or update query'''

        if not data:
            return

        rows = []
        for dat in data:
            row = []
            cols = []

            for key, value in dat.items():
                # whitelisting only columns in schema
                if key not in self.schema[table]['columns'].keys():
                    self.logger.warning(
                        "'%s.%s' with value '%s' present in API response but not in DB schema",
                        table,
                        key,
                        value)
                    continue
                cols.append(key)
                row.append(self._convert_value(table, key, value))

            rows.append((row))
            columns = ', '.join(cols)
            placeholders = ', '.join('?' * len(cols))

        sql = 'INSERT OR REPLACE INTO {}({}) VALUES ({})'.format(
            table, columns, placeholders)
        self.execute(sql, rows)

    def get_one(self, table, record_id):
        '''Returns data from one row of a table'''
        select_sql = '*'
        sql = 'SELECT {} FROM {} WHERE id == {}'.format(
            select_sql, table, record_id)
        return self.execute(sql).fetchone()

    def get_all(self, table, record_ids=None):
        '''Returns multiple data from multiple rows of a table'''

        select_sql = '*'
        if isinstance(record_ids, list):
            record_ids_sql = 'WHERE id IN (' + ', '.join(
                [str(record_id) for record_id in record_ids]) + ')'
        else:
            record_ids_sql = ''

        sql = 'SELECT {} FROM {} {}'.format(select_sql, table, record_ids_sql)
        return self.execute(sql).fetchall()