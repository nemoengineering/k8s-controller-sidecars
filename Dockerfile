FROM golang:1.18.1 AS build

WORKDIR /usr/src/k8s-controller-sidecars

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-s -w" -a -installsuffix cgo -o k8s-controller-sidecars .



FROM scratch
COPY --from=build /usr/src/k8s-controller-sidecars/k8s-controller-sidecars /

CMD ["/k8s-controller-sidecars"]
