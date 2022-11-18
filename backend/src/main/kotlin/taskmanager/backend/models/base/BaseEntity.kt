package taskmanager.backend.models.base

import java.util.*

abstract class BaseEntity<E>(
    val createdAt: Date = Date(),
    var updatedAt: Date? = null
)