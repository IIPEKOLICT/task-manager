package taskmanager.backend.services.impl

import software.amazon.awssdk.auth.credentials.EnvironmentVariableCredentialsProvider
import software.amazon.awssdk.core.sync.RequestBody
import software.amazon.awssdk.services.s3.S3Client
import software.amazon.awssdk.services.s3.model.*
import software.amazon.awssdk.services.s3.presigner.S3Presigner
import software.amazon.awssdk.services.s3.presigner.model.GetObjectPresignRequest
import taskmanager.backend.services.S3Service
import taskmanager.backend.shared.Configuration
import java.time.Duration

class S3ServiceImpl(private val configuration: Configuration) : S3Service {

    private val client = S3Client
        .builder()
        .credentialsProvider(EnvironmentVariableCredentialsProvider.create())
        .build()

    private val presigner = S3Presigner.builder().build()

    override fun save(path: String, content: ByteArray) {
        try {
            val requestParams: PutObjectRequest = PutObjectRequest.builder()
                .bucket(configuration.s3BucketName)
                .key(path)
                .build()

            val response = client.putObject(requestParams, RequestBody.fromBytes(content))

            println(response)
        } catch (e: S3Exception) {
            println(e.stackTraceToString())
            throw RuntimeException()
        }
    }

    override fun get(path: String): ByteArray {
        try {
            println(path)

            val requestParams: GetObjectRequest = GetObjectRequest.builder()
                .bucket(configuration.s3BucketName)
                .key(path)
                .build()

            return client.getObjectAsBytes(requestParams).asByteArray()
        } catch (e: S3Exception) {
            println(e.stackTraceToString())
            throw RuntimeException()
        }
    }

    override fun getUrlOrNull(path: String?): String? {
        try {
            if (path == null) return null

            val getObjectRequest = GetObjectRequest.builder()
                .bucket(configuration.s3BucketName)
                .key(path)
                .build()

            val getObjectPresignRequest = GetObjectPresignRequest.builder()
                .signatureDuration(Duration.ofDays(1))
                .getObjectRequest(getObjectRequest)
                .build()

            return presigner.presignGetObject(getObjectPresignRequest).url().toString()
        } catch (e: S3Exception) {
            println("S3Error: ${e.stackTraceToString()}")
            return null
        }
    }

    override fun delete(path: String): Boolean {
        return try {
            val objectIdentifier = ObjectIdentifier.builder()
                .key(path)
                .build()

            val deleteParams: Delete = Delete.builder().objects(objectIdentifier).build()

            val deleteRequest: DeleteObjectsRequest = DeleteObjectsRequest.builder()
                .bucket(configuration.s3BucketName)
                .delete(deleteParams)
                .build()

            client.deleteObjects(deleteRequest)
            true
        } catch (e: S3Exception) {
            println("S3Error: ${e.stackTraceToString()}")
            false
        }
    }
}