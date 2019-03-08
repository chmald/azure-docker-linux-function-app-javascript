docker build . -t node-function:v1

docker run -it -p 8080:80 -e FUNCTIONS_WORKER_RUNTIME="node" -e AzureWebJobsStorage="StorageConnectionString" node-function:v1

http://localhost:8080/api/tablestoragetest?name=SomethingToPass
