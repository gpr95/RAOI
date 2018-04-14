FROM golang:latest
RUN mkdir /app
COPY . /app/
WORKDIR /app
RUN go get github.com/denisenkom/go-mssqldb
RUN go build -o main .
CMD ["/app/main"]

