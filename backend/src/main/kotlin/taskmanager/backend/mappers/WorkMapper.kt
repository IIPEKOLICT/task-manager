package taskmanager.backend.mappers

import taskmanager.backend.dtos.response.WorkResponseDto
import taskmanager.backend.mappers.base.CreatedByUserEntityMapper
import taskmanager.backend.models.*
import taskmanager.backend.services.UserService

class WorkMapper(
    override val userService: UserService
) : CreatedByUserEntityMapper<Work, WorkResponseDto>(userService)