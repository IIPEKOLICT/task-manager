package taskmanager.backend.models

import org.bson.types.ObjectId
import taskmanager.backend.models.base.impl.BaseEntityImpl
import taskmanager.backend.models.interfaces.AttachedToProjectEntity
import taskmanager.backend.shared.ColorGenerator
import java.util.Date

data class Task(
    override val createdBy: ObjectId,
    val assignedTo: ObjectId,
    override val project: ObjectId,
    val blockedBy: Set<ObjectId> = emptySet(),
    val works: Set<ObjectId> = emptySet(),
    val comments: Set<ObjectId> = emptySet(),
    val notes: Set<ObjectId> = emptySet(),
    val attachments: Set<ObjectId> = emptySet(),
    val tags: Set<ObjectId> = emptySet(),

    var title: String,
    var description: String,
    var color: String = ColorGenerator.generateHexColor(),
    var priority: String,
    var status: String,
    var expectedTime: Date? = null
) : BaseEntityImpl(), AttachedToProjectEntity