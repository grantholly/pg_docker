package main

import (
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

func main() {
	ip := ""
	dsn := fmt.Sprintf("postgres://postgres:postgres@%s:5432", ip)
	pool := 10

	db := Connect(dsn, pool)
	fmt.Println(db)
}
