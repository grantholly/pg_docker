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

func Query (db pgx.ConnPool) []string {
     q := `SELECT doc from public.jsonb_test;`
     fmt.Println(q)
     res := []string{}

     rows, err := db.Query(q)
     if err != nil {
     	    fmt.Sprintf("could not run query: %s", q)
     }
     defer rows.Close()

     for rows.Next() {
     	    var r string
	    err = rows.Scan(&r)
	    if err != nil {
	           fmt.Println(err)
	    }
	    res = append(res, r)
     }
     return res     
}

func Insert (db pgx.ConnPool) {
     q := `INSERT INTO public.jsonb_test (id, doc) VALUES ($1, $2)`
     stmt, err := db.Prepare("json_insert", q)
     if err != nil {
            fmt.Sprintf("could not create prepared statement: %s", q)
     }

     new_profile := `
     {
     "id": 4, "profileName": "Nana",
     "hobbies": ["yoyos"],
     "location": {"state": "OR", "zip": 97206, "cool": true}
     }
     `
     res, err := db.Exec(stmt.SQL, 4, new_profile)
     if err != nil {
            fmt.Sprintf("could not execute SQL: %s", q)
     }
     fmt.Println(res)
}

func main () {
     dsn := "postgres://demo_admin:postgres@192.168.0.101:5432/demo"
     pool := 5

     db := Connect(dsn, pool)

     fmt.Println(Query(*db))
     Insert(*db)
     fmt.Println(Query(*db))
}