package main

import(
	"fmt"

	"github.com/jackc/pgx"
)

func Connect(dsn string, maxConn int) *pgx.ConnPool {
     pgConfig, err := pgx.ParseURI(dsn)
     if err != nil {
     	    fmt.Sprintf("could not parse DSN: %s", dsn)
     }

     conn, err := pgx.NewConnPool(pgx.ConnPoolConfig{
            ConnConfig:     pgConfig,
	    MaxConnections: maxConn,
     })
     if err != nil {
            fmt.Println("could not create connection pool")
     }

     return conn
}

func main () {
          dsn := "postgres://postgres:postgres@192.168.0.101:5432"
	  pool := 10

	  db := Connect(dsn, pool)
	  fmt.Println(db)
}