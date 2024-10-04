from azure.storage.blob import ContainerClient, BlobClient, BlobServiceClient

connection_string = ''
account_key = ""
account_name = "azurestoragedb"

blob_storage_client = BlobServiceClient.from_connection_string(connection_string)

blobclient = BlobServiceClient(account_url= 
                               f"https://{account_name}.blob.core.windows.net/",
                               credential=account_key)
# Access Container and List Blobs
container_name = "azblobcontainer"
container_client = blob_storage_client.get_container_client(container_name)

# Upload to Blobs
local_file_path = "C:/Users/AMIT/Downloads/transformed_sales_data.json"
with open(local_file_path, "rb") as fileobj:
    container_client.upload_blob("sales_data.json", fileobj)
    print(f"Blob uploaded")

# List all blobs in the container
blob_list = container_client.list_blob_names()

for blobs in blob_list:
    print(blobs)