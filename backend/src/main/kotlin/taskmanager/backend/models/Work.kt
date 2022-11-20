package taskmanager.backend.models

import org.bson.types.ObjectId
import taskmanager.backend.models.base.impl.BaseEntityImpl
import taskmanager.backend.models.interfaces.AttachedToTaskEntity
import java.util.Date

data class Work(
    override val createdBy: ObjectId,
    override val task: ObjectId,

    var description: String,
    var startDate: Date,
    var endDate: Date
) : BaseEntityImpl(), AttachedToTaskEntity