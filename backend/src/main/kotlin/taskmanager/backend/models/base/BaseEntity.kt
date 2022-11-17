package taskmanager.backend.models.base

import java.util.*

abstract class BaseEntity<E>(
    var createdAt: Date = Date(),
    var updatedAt: Date? = null
)