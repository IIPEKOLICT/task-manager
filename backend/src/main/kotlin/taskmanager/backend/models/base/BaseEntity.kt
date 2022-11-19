package taskmanager.backend.models.base

import org.bson.types.ObjectId
import java.util.*

interface BaseEntity {
    val _id: ObjectId
    val createdAt: Date
    var updatedAt: Date?
}