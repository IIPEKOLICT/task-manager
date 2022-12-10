package taskmanager.backend.mappers

import taskmanager.backend.dtos.response.CommentResponseDto
import taskmanager.backend.mappers.base.CreatedByUserEntityMapper
import taskmanager.backend.models.*
import taskmanager.backend.services.UserService

class CommentMapper(
    override val userService: UserService
) : CreatedByUserEntityMapper<Comment, CommentResponseDto>(userService)