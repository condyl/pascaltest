# Pascal SQLite Example

This repository contains example Pascal programs that demonstrate how to interact with an SQLite database. The programs `p.pas` and `q.pas` are used to insert and query data from the database, respectively.

## Prerequisites

Before running the programs, you need to install SQLite and its development libraries. You can do this by running the following command:

```sh
sudo apt-get install sqlite3 libsqlite3-dev
```

## Files   

- `p.pas`: This program creates a table and inserts 10 unique fruit values into the database.
- `q.pas`: This program queries the database for a fruit by its ID, which is provided as a command-line argument.

## Usage

1. Compile the programs using the Free Pascal Compiler (FPC):

```sh
fpc p.pas
fpc q.pas
```

2. Run the `p` program to create the table and insert data: 

```sh
./p
```

3. Run the `q` program with an ID to query the database:

```sh
./q <ID>
```

Replace <ID> with an integer value between 1 and 10.

## Example
```sh
./p
./q 1
```

This will output the fruit corresponding to ID 1.