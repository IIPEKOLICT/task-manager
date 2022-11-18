package taskmanager.backend.controllers

import com.github.iipekolict.knest.annotations.classes.Controller
import com.github.iipekolict.knest.annotations.methods.*
import com.github.iipekolict.knest.annotations.properties.Body
import com.github.iipekolict.knest.annotations.properties.Param
import io.ktor.http.content.*
import io.ktor.server.application.*
import io.ktor.server.plugins.*
import io.ktor.server.response.*
import org.bson.types.ObjectId
import org.koin.java.KoinJavaComponent.inject
import taskmanager.backend.dtos.request.*
import taskmanager.backend.plugins.annotations.JwtUser
import taskmanager.backend.exceptions.custom.ForbiddenException
import taskmanager.backend.models.Project
import taskmanager.backend.models.Tag
import taskmanager.backend.models.User
import taskmanager.backend.services.ProjectService
import taskmanager.backend.services.TagService

@Controller("projects")
class ProjectController {

    private val projectService by inject<ProjectService>(ProjectService::class.java)
    private val tagService by inject<TagService>(TagService::class.java)

    @Get
    @Authentication(["auth-jwt"])
    suspend fun getAll(@JwtUser user: User): List<Project> {
        return projectService.getByUser(user._id)
    }

    @Get("{id}")
    @Authentication(["auth-jwt"])
    suspend fun getById(@Param("id") id: String): Project {
        return projectService.getById(id)
    }

    @Get("{id}/tags")
    @Authentication(["auth-jwt"])
    suspend fun getProjectTags(@Param("id") id: String): List<Tag> {
        return tagService.getByProject(id)
    }

    @Post
    @Authentication(["auth-jwt"])
    suspend fun create(
        @JwtUser user: User,
        @Body(type = CreateProjectDto::class) dto: CreateProjectDto
    ): Project {
        return projectService.create(user._id, dto)
    }

    @Post("{id}/tags")
    @Authentication(["auth-jwt"])
    suspend fun createProjectTag(
        @JwtUser user: User,
        @Param("id") id: String,
        @Body("name") name: String
    ): Tag {
        return tagService.create(user._id, projectService.getById(id)._id, name)
    }

    @Patch("{id}/name")
    @Authentication(["auth-jwt"])
    suspend fun updateName(
        @JwtUser user: User,
        @Param("id") id: String,
        @Body("name") name: String
    ): Project {
        if (!projectService.isOwner(id, user._id)) {
            throw ForbiddenException("Вы не можете изменять этот проект")
        }

        return projectService.updateName(id, name)
    }

    @Patch("{id}/members")
    @Authentication(["auth-jwt"])
    suspend fun updateInfo(
        @JwtUser user: User,
        @Param("id") id: String,
        @Body("members") members: List<String>
    ): Project {
        if (!projectService.isOwner(id, user._id)) {
            throw ForbiddenException("Вы не можете изменять этот проект")
        }

        return projectService.updateMembers(id, members.map { ObjectId(it) })
    }

    @Delete("{id}")
    @Authentication(["auth-jwt"])
    suspend fun deleteById(
        @JwtUser user: User,
        @Param("id") id: String
    ): DeleteDto {
        if (!projectService.isOwner(id, user._id)) {
            throw ForbiddenException("Вы не можете удалить этот проект")
        }

        tagService.deleteByProject(id)
        return DeleteDto(projectService.deleteById(id))
    }
}