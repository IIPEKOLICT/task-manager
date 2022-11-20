package taskmanager.backend.services

interface S3Service {
    fun save(path: String, content: ByteArray)
    fun get(path: String): ByteArray
    fun getUrlOrNull(path: String?): String?
    fun delete(path: String): Boolean
}