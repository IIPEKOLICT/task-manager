package taskmanager.backend.models

import org.bson.types.ObjectId
import taskmanager.backend.models.base.impl.BaseEntityImpl
import taskmanager.backend.models.interfaces.AttachedToTaskEntity

data class Note(
    override val createdBy: ObjectId,
    override val task: ObjectId,

    var header: String,
    var text: String
) : BaseEntityImpl(), AttachedToTaskEntity