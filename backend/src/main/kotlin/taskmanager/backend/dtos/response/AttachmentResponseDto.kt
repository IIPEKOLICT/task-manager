package taskmanager.backend.dtos.response

data class AttachmentResponseDto(
    val _id: String,
    val type: String,
    val name: String,
    val url: String? = null,
)
