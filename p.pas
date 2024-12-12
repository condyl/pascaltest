program p;

uses
  sysutils, sqlite3;

var
  db: Psqlite3;
  stmt: Psqlite3_stmt;
  rc: Integer;
  sql: PChar;
  fruits: array[0..9] of String = ('Apple', 'Banana', 'Cherry', 'Date', 'Elderberry', 'Fig', 'Grape', 'Honeydew', 'Kiwi', 'Lemon');
  i: Integer;

procedure CheckError(rc: Integer; db: Psqlite3);
begin
  if rc <> SQLITE_OK then
  begin
    WriteLn('SQLite error: ', sqlite3_errmsg(db));
    Halt(1);
  end;
end;

begin
  // Open or create the database
  rc := sqlite3_open(PChar('example.db'), @db);
  CheckError(rc, db);

  // Create a table with ID and Fruit columns
  sql := PChar('CREATE TABLE IF NOT EXISTS TestTable (ID INTEGER PRIMARY KEY, Fruit TEXT);');
  rc := sqlite3_exec(db, sql, nil, nil, nil);
  CheckError(rc, db);

  // Insert 10 unique fruit values
  for i := 0 to 9 do
  begin
    sql := PChar('INSERT INTO TestTable (ID, Fruit) VALUES (' + IntToStr(i + 1) + ', ''' + fruits[i] + ''');');
    rc := sqlite3_exec(db, sql, nil, nil, nil);
    CheckError(rc, db);
  end;

  // Query the data
  sql := PChar('SELECT * FROM TestTable;');
  rc := sqlite3_prepare_v2(db, sql, -1, @stmt, nil);
  CheckError(rc, db);

  // Print results
  while sqlite3_step(stmt) = SQLITE_ROW do
  begin
    WriteLn('ID: ', sqlite3_column_int(stmt, 0), ', Fruit: ', sqlite3_column_text(stmt, 1));
  end;

  // Cleanup
  sqlite3_finalize(stmt);
  sqlite3_close(db);

  WriteLn('Program finished successfully.');
end.
