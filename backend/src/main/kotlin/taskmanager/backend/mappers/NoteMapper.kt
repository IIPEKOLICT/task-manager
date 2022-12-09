package taskmanager.backend.mappers

import taskmanager.backend.dtos.response.NoteResponseDto
import taskmanager.backend.mappers.base.CreatedByUserEntityMapper
import taskmanager.backend.models.*
import taskmanager.backend.services.UserService

class NoteMapper(
    override val userService: UserService
) : CreatedByUserEntityMapper<Note, NoteResponseDto>(userService)