package taskmanager.backend.plugins.exceptions.custom

import io.ktor.http.*
import taskmanager.backend.plugins.exceptions.custom.base.BaseException

class EntityNotFoundException(entityName: String)
    : BaseException("$entityName не найден(а)", HttpStatusCode.NotFound)