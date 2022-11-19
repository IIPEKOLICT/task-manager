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
import taskmanager.backend.models.Task
import taskmanager.backend.models.User
import taskmanager.backend.services.ProjectService
import taskmanager.backend.services.TagService
import taskmanager.backend.services.TaskService

@Controller("projects")
class ProjectController {

    private val projectService by inject<ProjectService>(ProjectService::class.java)
    private val tagService by inject<TagService>(TagService::class.java)
    private val taskService by inject<TaskService>(TaskService::class.java)

    @Get
    @Authentication(["auth-jwt"])
    suspend fun getAll(@JwtUser user: User): List<Project> {
        return projectService.getByUser(user._id)
    }

    @Get("{id}")
    @Authentication(["auth-jwt"])
    suspend fun getById(@Param("id") id: String): Project {
        return projectService.getById(ObjectId(id))
    }

    @Get("{id}/tags")
    @Authentication(["auth-jwt"])
    suspend fun getProjectTags(@Param("id") id: String): List<Tag> {
        return tagService.getByProject(ObjectId(id))
    }

    @Get("{id}/tasks")
    @Authentication(["auth-jwt"])
    suspend fun getProjectTasks(@Param("id") id: String): List<Task> {
        return taskService.getByProject(ObjectId(id))
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
        return tagService.create(user._id, projectService.getById(ObjectId(id))._id, name)
    }

    @Post("{id}/tasks")
    @Authentication(["auth-jwt"])
    suspend fun createProjectTask(
        @JwtUser user: User,
        @Param("id") id: String,
        @Body(type = CreateTaskDto::class) dto: CreateTaskDto
    ): Task {
        return taskService.create(user._id, projectService.getById(ObjectId(id))._id, dto)
    }

    @Patch("{id}/name")
    @Authentication(["auth-jwt"])
    suspend fun updateName(
        @JwtUser user: User,
        @Param("id") id: String,
        @Body("name") name: String
    ): Project {
        val project: Project = projectService.getById(ObjectId(id))

        if (!projectService.isOwner(project, user._id)) {
            throw ForbiddenException("Вы не можете изменять этот проект")
        }

        return projectService.updateName(project._id, name)
    }

    @Patch("{id}/members")
    @Authentication(["auth-jwt"])
    suspend fun updateInfo(
        @JwtUser user: User,
        @Param("id") id: String,
        @Body("members") members: List<String>
    ): Project {
        val project: Project = projectService.getById(ObjectId(id))

        if (!projectService.isOwner(project, user._id)) {
            throw ForbiddenException("Вы не можете изменять этот проект")
        }

        return projectService.updateMembers(project._id, members.map { ObjectId(it) })
    }

    @Delete("{id}")
    @Authentication(["auth-jwt"])
    suspend fun deleteById(
        @JwtUser user: User,
        @Param("id") id: String
    ): DeleteDto {
        val project: Project = projectService.getById(ObjectId(id))

        if (!projectService.isOwner(project, user._id)) {
            throw ForbiddenException("Вы не можете удалить этот проект")
        }

        tagService.deleteByProject(project._id)
        return DeleteDto(projectService.deleteById(project._id))
    }
}