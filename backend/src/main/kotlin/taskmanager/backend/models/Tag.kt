package taskmanager.backend.models

import org.bson.types.ObjectId
import taskmanager.backend.models.base.impl.BaseEntityImpl
import taskmanager.backend.models.interfaces.CreatedByUserEntity
import taskmanager.backend.shared.ColorGenerator

data class Tag(
    val project: ObjectId,
    override val createdBy: ObjectId,

    var name: String,
    var color: String = ColorGenerator.generateHexColor()
) : BaseEntityImpl(), CreatedByUserEntity