program q;

uses
  sysutils, sqlite3;

var
  db: Psqlite3;
  stmt: Psqlite3_stmt;
  rc: Integer;
  sql: PChar;
  id: Integer;
  idStr: String;

procedure CheckError(rc: Integer; db: Psqlite3);
begin
  if rc <> SQLITE_OK then
  begin
    WriteLn('SQLite error: ', sqlite3_errmsg(db));
    Halt(1);
  end;
end;

begin
  // Ensure the user provided an ID as an argument
  if ParamCount <> 1 then
  begin
    WriteLn('Usage: q <ID>');
    Halt(1);
  end;

  // Get the ID from command-line arguments
  idStr := ParamStr(1);
  id := StrToIntDef(idStr, -1);

  if id = -1 then
  begin
    WriteLn('Invalid ID. Please enter a valid integer.');
    Halt(1);
  end;

  // Open the database
  rc := sqlite3_open(PChar('example.db'), @db);
  CheckError(rc, db);

  // Prepare the SQL query to get the fruit by ID
  sql := PChar('SELECT Fruit FROM TestTable WHERE ID = ?');
  rc := sqlite3_prepare_v2(db, sql, -1, @stmt, nil);
  CheckError(rc, db);

  // Bind the ID to the SQL query
  sqlite3_bind_int(stmt, 1, id);

  // Execute the query and print the result
  rc := sqlite3_step(stmt);
  if rc = SQLITE_ROW then
  begin
    WriteLn('Fruit for ID ', id, ': ', sqlite3_column_text(stmt, 0));
  end
  else
  begin
    WriteLn('No fruit found for ID ', id);
  end;

  // Cleanup
  sqlite3_finalize(stmt);
  sqlite3_close(db);

  WriteLn('Program finished successfully.');
end.
