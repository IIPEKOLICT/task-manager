package taskmanager.backend.models

import org.bson.codecs.pojo.annotations.BsonId
import org.bson.types.ObjectId
import taskmanager.backend.models.base.BaseEntity

data class Tag(
    @BsonId val _id: ObjectId = ObjectId(),
    val project: ObjectId,
    val createdBy: ObjectId,

    var name: String,
    var color: String = generateColor()
) : BaseEntity() {

    companion object {
        fun generateColor(): String {
            val allowedChars: List<Char> = ('a'..'f') + ('0'..'9')
            val hex = (1..6).map { allowedChars.random() }.joinToString("")
            return "#$hex"
        }
    }
}