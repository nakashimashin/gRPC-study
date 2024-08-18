FROM golang:1.22

RUN apt-get update && apt-get install -y protobuf-compiler && rm -rf /var/lib/apt/lists/*

WORKDIR /grpc-server

COPY go.mod go.sum ./

RUN go mod tidy
RUN go mod download

RUN go install github.com/air-verse/air@latest
RUN go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
RUN go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
RUN go install github.com/fullstorydev/grpcurl/cmd/grpcurl@latest

COPY . .

CMD ["air", "-c", ".air.toml"]