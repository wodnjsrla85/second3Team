# -*- coding: utf-8 -*-
"""
author      : Kenny
Description : MySQL의 python Database와 CRUD on Web
http://127.0.0.1:8000/iris?sepalLength=...&...
"""

from fastapi import FastAPI
import joblib
import pymysql
# import json

app = FastAPI()

def connect():
    # MySQL Connection
    conn = pymysql.connect(
        host='127.0.0.1',
        user='root',
        password='qwer1234',
        db='education',
        charset='utf8'
    )
    return conn


@app.get("/select")
async def select():
    # Connection으로 부터 Cursor 생성
    conn = connect()
    curs = conn.cursor()

    # SQL 문장
    sql = "SELECT * FROM student"
    curs.execute(sql)
    rows = curs.fetchall()
    conn.close()
    print(rows)

    return {'results': rows} 

@app.get("/insert")
async def insert(code: str=None, name: str=None, dept: str=None, phone: str=None, address: str=None):
    # Connection으로 부터 Cursor 생성
    conn = connect()
    curs = conn.cursor()

    # SQL 문장
    try:
        sql = "insert into student(scode, sname, sdept, sphone, saddress) values (%s,%s,%s,%s,%s)"
        curs.execute(sql, (code, name, dept, phone, address))
        conn.commit()
        conn.close()
        return {'result':'OK'}
    except Exception as ex:
        conn.close()
        print("Error :", ex)
        return {'result':'Error'}
    

@app.get("/update")
async def update(code: str=None, name: str=None, dept: str=None, phone: str=None, address: str=None):
    # Connection으로 부터 Cursor 생성
    conn = connect()
    curs = conn.cursor()

    # SQL 문장
    try:
        sql = "update student set sname=%s, sdept=%s, sphone=%s, saddress=%s where scode=%s"
        curs.execute(sql, (name, dept, phone, address, code))
        conn.commit()
        conn.close()
        return {'result':'OK'}  
    except Exception as ex:
        conn.close()
        print("Error :", ex)
        return {'result':'Error'}

@app.get("/delete")
async def delete(code: str=None):
    # Connection으로 부터 Cursor 생성
    conn = connect()
    curs = conn.cursor()

    # SQL 문장
    try:
        sql = "delete from student where scode = %s"
        curs.execute(sql, (code))
        conn.commit()
        conn.close()
        return {'result':'OK'}
    except Exception as ex:
        conn.close()
        print("Error :", ex)
        return {'result':'Error'}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="127.0.0.1", port=8000)

# uvicorn students:app —reload