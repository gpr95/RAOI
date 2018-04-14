FROM golang:latest

# Copy go application to sources folder
RUN mkdir /sources
COPY . /sources/
WORKDIR /sources

# Install go packages
RUN go get github.com/denisenkom/go-mssqldb

# Build and compile go packages (doesn't install results)
RUN go build -o compiled-application .
CMD ["/sources/compiled-application"]

