CREATE OR REPLACE SEQUENCE PUBLIC.DemoUsers_ID
   START WITH 1
   INCREMENT BY 1
COMMENT = 'FOR TABLE-COLUMN PUBLIC.DemoUsers.ID';

                                                 /* <sc-table> DemoUser T12</sc-table> */
CREATE TABLE PUBLIC.DemoUsers (
   ID INTEGER DEFAULT PUBLIC.DemoUsers_ID.NEXTVAL /*** MSC-WARNING - MSCEWI1048 - SEQUENCE -  GENERATED BY DEFAULT  START WITH 1 INCREMENT BY 1 MAXVALUE 9999 ***/ ,
   Name VARCHAR(255) NOT NULL,
   Birthday DATE NOT NULL,
   CityCode INTEGER NOT NULL,
   Email VARCHAR(255) NOT NULL,
   UNIQUE (ID)
);

/* <sc-insert> </sc-insert> */
INSERT INTO PUBLIC.DemoUsers (Name, Birthday, CityCode, Email)
VALUES ('Emma Ezquivel', '2021-11-11', 123, 'emma@mobilize.se');
/* <sc-insert> </sc-insert> */
INSERT INTO PUBLIC.DemoUsers (Name, Birthday, CityCode, Email)
VALUES ('Daniel Duran', '2021-10-11', 456, 'daniel@mobilize.se');
/* <sc-insert> </sc-insert> */
INSERT INTO PUBLIC.DemoUsers (Name, Birthday, CityCode, Email)
VALUES ('Jennifer Jones', '2021-09-10', 789, 'jennifer@mobilize.se');
/* <sc-insert> </sc-insert> */
INSERT INTO PUBLIC.DemoUsers (Name, Birthday, CityCode, Email)
VALUES ('Joseph Jar', '2021-08-09', 741, 'joseph@mobilize.se');

/* <sc-view> DemoUserView </sc-view> */
CREATE OR REPLACE VIEW PUBLIC.View_DemoUsers
(Name, CityCode, Email)
AS
SELECT
   Name,
   CityCode,
   Email
  FROM
   PUBLIC.DemoUsers;

/* <sc-procedure> InsertDemoUsers </sc-procedure> */
   CREATE OR REPLACE PROCEDURE PUBLIC.InsertDemoUsers (IN_NAME STRING, IN_BIRTHDAY DATE, IN_CITYCODE FLOAT, IN_EMAIL STRING
  )
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS CALLER
   AS
   $$
 	// REGION SnowConvert Helpers Code
	var HANDLE_NOTFOUND;
	var _RS, ROW_COUNT, _ROWS, MESSAGE_TEXT, SQLCODE = 0, SQLSTATE = '00000', ERROR_HANDLERS, ACTIVITY_COUNT = 0, INTO, _OUTQUERIES = [], DYNAMIC_RESULTS = -1;
	var formatDate = (arg) => (new Date(arg - (arg.getTimezoneOffset() * 60000))).toISOString().slice(0,-1);
	var fixBind = function (arg) {
	   arg = arg == undefined ? null : arg instanceof Date ? formatDate(arg) : arg;
	   return arg;
	};
	var EXEC = function (stmt,binds,noCatch,catchFunction,opts) {
	   try {
	      binds = binds ? binds.map(fixBind) : binds;
	      _RS = snowflake.createStatement({
	            sqlText : stmt,
	            binds : binds
	         });
	      _ROWS = _RS.execute();
	      ROW_COUNT = _RS.getRowCount();
	      ACTIVITY_COUNT = _RS.getNumRowsAffected();
	      HANDLE_NOTFOUND && HANDLE_NOTFOUND(_RS);
	      if (INTO) return {
	         INTO : function () {
	            return INTO();
	         }
	      };
	      if (_OUTQUERIES.length < DYNAMIC_RESULTS) _OUTQUERIES.push(_ROWS.getQueryId());
	      if (opts && opts.temp) return _ROWS.getQueryId();
	   } catch(error) {
	      MESSAGE_TEXT = error.message;
	      SQLCODE = error.code;
	      SQLSTATE = error.state;
	      var msg = `ERROR CODE: ${SQLCODE} SQLSTATE: ${SQLSTATE} MESSAGE: ${MESSAGE_TEXT}`;
	      if (catchFunction) catchFunction(error);
	      if (!noCatch && ERROR_HANDLERS) ERROR_HANDLERS(error); else throw new Error(msg);
	   }
	};
	// END REGION
	
	EXEC(`INSERT INTO PUBLIC.DemoUsers (Name, Birthday, CityCode, Email)
	VALUES (:1, :2, :3, :4)`,[IN_NAME,IN_BIRTHDAY,IN_CITYCODE,IN_EMAIL]);
 
$$;

/* <sc-call> </sc-call> */
   CALL PUBLIC.InsertDemoUsers('TestTable', '2020-12-12', 420, 'testTable@email.com');

/* <sc-procedure> UpdateDemoUsers </sc-procedure> */
   CREATE OR REPLACE PROCEDURE PUBLIC.UpdateDemoUsers (IN_ID FLOAT, IN_NAME STRING, IN_BIRTHDAY DATE, IN_CITYCODE FLOAT, IN_EMAIL STRING
  )
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS CALLER
   AS
   $$
 	// REGION SnowConvert Helpers Code
	var HANDLE_NOTFOUND;
	var _RS, ROW_COUNT, _ROWS, MESSAGE_TEXT, SQLCODE = 0, SQLSTATE = '00000', ERROR_HANDLERS, ACTIVITY_COUNT = 0, INTO, _OUTQUERIES = [], DYNAMIC_RESULTS = -1;
	var formatDate = (arg) => (new Date(arg - (arg.getTimezoneOffset() * 60000))).toISOString().slice(0,-1);
	var fixBind = function (arg) {
	   arg = arg == undefined ? null : arg instanceof Date ? formatDate(arg) : arg;
	   return arg;
	};
	var EXEC = function (stmt,binds,noCatch,catchFunction,opts) {
	   try {
	      binds = binds ? binds.map(fixBind) : binds;
	      _RS = snowflake.createStatement({
	            sqlText : stmt,
	            binds : binds
	         });
	      _ROWS = _RS.execute();
	      ROW_COUNT = _RS.getRowCount();
	      ACTIVITY_COUNT = _RS.getNumRowsAffected();
	      HANDLE_NOTFOUND && HANDLE_NOTFOUND(_RS);
	      if (INTO) return {
	         INTO : function () {
	            return INTO();
	         }
	      };
	      if (_OUTQUERIES.length < DYNAMIC_RESULTS) _OUTQUERIES.push(_ROWS.getQueryId());
	      if (opts && opts.temp) return _ROWS.getQueryId();
	   } catch(error) {
	      MESSAGE_TEXT = error.message;
	      SQLCODE = error.code;
	      SQLSTATE = error.state;
	      var msg = `ERROR CODE: ${SQLCODE} SQLSTATE: ${SQLSTATE} MESSAGE: ${MESSAGE_TEXT}`;
	      if (catchFunction) catchFunction(error);
	      if (!noCatch && ERROR_HANDLERS) ERROR_HANDLERS(error); else throw new Error(msg);
	   }
	};
	// END REGION
	
	EXEC(`UPDATE PUBLIC.DemoUsers
	   SET
	      Name = :1,
	      Birthday = :2,
	      CityCode = :3,
	      Email = :4
	   WHERE
	      ID = :5`,[IN_NAME,IN_BIRTHDAY,IN_CITYCODE,IN_EMAIL,IN_ID]);
 
$$;

/* <sc-call> </sc-call> */
   CALL PUBLIC.UpdateDemoUsers(1, 'TestUpdate', '2020-12-12', 840, 'testInsert@email.com');