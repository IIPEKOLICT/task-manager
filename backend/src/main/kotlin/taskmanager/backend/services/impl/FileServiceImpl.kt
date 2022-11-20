package taskmanager.backend.services.impl

import io.ktor.http.content.*
import taskmanager.backend.exceptions.custom.InternalServerException
import taskmanager.backend.services.FileService

class FileServiceImpl : FileService {

    override fun convertFileItemToByteArray(file: PartData.FileItem): ByteArray {
        try {
            return file.streamProvider().use { it.readBytes() }
        } catch (e: Exception) {
            throw InternalServerException("Ошибка чтения файла")
        }
    }
}