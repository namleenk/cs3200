#!/usr/bin/env python3
import pymysql
from pymysql import cursors


def run():
    # creating connection
    username = input("Please enter a username:\t")
    password = input("Please enter a password:\t")
    try:
        connection = pymysql.connect(host='localhost', user=username, password=password,
                                     db='animal_shelter', charset='utf8mb4', cursorclass=pymysql.cursors.DictCursor)
        cursor = connection.cursor()
        print('Connection successful')
    except BaseException:
        print("Connection unsuccessful. Please check your username/password and try again.")
        return



if __name__ == '__main__':
    run()
