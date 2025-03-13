package main

import (
	"context"
	"log"
	"os"

	"github.com/minio/minio-go/v7"
	"github.com/minio/minio-go/v7/pkg/credentials"
)

type S3Client struct {
	Client     *minio.Client
	BucketName string
}

func GetS3Client() S3Client {
	ENDPOINT := os.Getenv("MINIO_ENDPOINT")
	log.Println("endppoint", ENDPOINT)
	ACCESS_KEY := os.Getenv("S3_ACCESS_KEY")
	SECRET_KEY := os.Getenv("S3_SECRET_KEY")
	BUCKET := os.Getenv("S3_BUCKET_NAME")

	client, err := minio.New(ENDPOINT, &minio.Options{
		Creds:  credentials.NewStaticV4(ACCESS_KEY, SECRET_KEY, ""),
		Secure: false,
	})
	if err != nil {
		log.Fatal("s3-get-client-error:", err.Error())
	}

	return S3Client{
		Client:     client,
		BucketName: BUCKET,
	}
}

func (s3 S3Client) UploadFile(objectName string, filePath string) error {
	ctx := context.Background()
	// s3 := GetS3Client()
	info, err := s3.Client.FPutObject(ctx, s3.BucketName, objectName, filePath, minio.PutObjectOptions{})
	if err != nil {
		log.Println("upload-file:", err.Error())
		return err
	}

	log.Println("Success upload!", info.ChecksumCRC32)
	return nil
}
