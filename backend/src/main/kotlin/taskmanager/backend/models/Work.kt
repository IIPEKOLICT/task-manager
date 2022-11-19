package taskmanager.backend.models

import org.bson.types.ObjectId
import taskmanager.backend.models.base.impl.BaseEntityImpl
import taskmanager.backend.models.interfaces.CreatedByUserEntity
import java.util.Date

data class Work(
    override val createdBy: ObjectId,
    val task: ObjectId,

    var description: String,
    var startDate: Date,
    var endDate: Date
) : BaseEntityImpl(), CreatedByUserEntity