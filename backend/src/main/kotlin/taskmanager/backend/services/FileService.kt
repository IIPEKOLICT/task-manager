package taskmanager.backend.services

import io.ktor.http.content.*

interface FileService {
    fun convertFileItemToByteArray(file: PartData.FileItem): ByteArray
}