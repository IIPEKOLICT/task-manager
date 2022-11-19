package taskmanager.backend.models

import org.bson.types.ObjectId
import taskmanager.backend.models.base.impl.BaseEntityImpl
import taskmanager.backend.models.interfaces.CreatedByUserEntity

data class Project(
    override val createdBy: ObjectId,
    val members: Set<ObjectId> = emptySet(),
    val tasks: Set<ObjectId> = emptySet(),
    val tags: Set<ObjectId> = emptySet(),

    var name: String,
) : BaseEntityImpl(), CreatedByUserEntity