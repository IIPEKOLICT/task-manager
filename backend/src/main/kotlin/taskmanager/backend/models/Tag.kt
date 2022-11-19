package taskmanager.backend.models

import org.bson.types.ObjectId
import taskmanager.backend.models.base.impl.BaseEntityImpl
import taskmanager.backend.models.interfaces.CreatedByUserEntity

data class Tag(
    val project: ObjectId,
    override val createdBy: ObjectId,

    var name: String,
    var color: String = generateColor()
) : BaseEntityImpl(), CreatedByUserEntity {

    companion object {
        fun generateColor(): String {
            val allowedChars: List<Char> = ('a'..'f') + ('0'..'9')
            val hex = (1..6).map { allowedChars.random() }.joinToString("")
            return "#$hex"
        }
    }
}