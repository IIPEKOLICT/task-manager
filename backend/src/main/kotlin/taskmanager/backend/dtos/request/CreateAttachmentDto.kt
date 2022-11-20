package taskmanager.backend.dtos.request

data class CreateAttachmentDto(
    val name: String,
    val type: String,
    val path: String
)
