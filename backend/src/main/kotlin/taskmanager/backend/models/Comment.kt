package taskmanager.backend.models

import org.bson.types.ObjectId
import taskmanager.backend.models.base.impl.BaseEntityImpl
import taskmanager.backend.models.interfaces.AttachedToTaskEntity

data class Comment(
    override val createdBy: ObjectId,
    override val task: ObjectId,

    var text: String
) : BaseEntityImpl(), AttachedToTaskEntity