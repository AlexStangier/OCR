package main

import (
	"context"
	"fmt"
	"log"

	documentai "cloud.google.com/go/documentai/apiv1"
	"cloud.google.com/go/storage"
	"google.golang.org/api/iterator"
)

func main() {
	ctx := context.Background()
	client, err := storage.NewClient(ctx)

	if err != nil {
		log.Fatal("Failed to Authenticate")
	}

	objects := getBucketContent(client, ctx, "ocrtest-image-bucket-cw-academy-sandbox-alex")
	fmt.Println(objects[0].Name)

}

func getBucketContent(client *storage.Client, ctx context.Context, bucketName string) []*storage.ObjectAttrs {
	bkt := client.Bucket(bucketName)

	var bucketObjects []*storage.ObjectAttrs

	//get all items in bucket
	objects := bkt.Objects(ctx, nil)
	for {
		attrs, err := objects.Next()
		if err == iterator.Done {
			break
		}
		if err != nil {
			log.Fatal("Failed to iterate all Bucket Objects.")
		}

		bucketObjects = append(bucketObjects, attrs)
	}

	return bucketObjects
}

func analyzeDocument(ctx context.Context) {
	docai, err := documentai.NewDocumentProcessorClient(ctx)
	if err != nil {
		log.Fatal("Failed to instanciate Doc AI.")
	}

	//req := &documentaipb.ProcessRequest

	docai.Close()
}

//TODO docker tag go-ocr europe-west1-docker.pkg.dev/cw-academy-sandbox-alex/ocr/go-ocr:0.1
//TODO docker push europe-west1-docker.pkg.dev/cw-academy-sandbox-alex/ocr/go-ocr:0.1
