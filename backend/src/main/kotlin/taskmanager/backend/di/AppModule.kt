package taskmanager.backend.di

import io.ktor.server.application.*
import org.koin.core.module.Module
import org.koin.dsl.module
import taskmanager.backend.controllers.*
import taskmanager.backend.enums.CollectionInfo
import taskmanager.backend.mappers.CommentMapper
import taskmanager.backend.mappers.NoteMapper
import taskmanager.backend.mappers.TaskMapper
import taskmanager.backend.mappers.WorkMapper
import taskmanager.backend.plugins.middlewares.MiddlewareContainer
import taskmanager.backend.services.*
import taskmanager.backend.services.impl.*
import taskmanager.backend.shared.DatabaseManager
import taskmanager.backend.shared.Configuration

object AppModule {

    fun get(environment: ApplicationEnvironment): Module {
        val configuration = Configuration(environment.config)
        val database = DatabaseManager(configuration).init().getDatabase()

        return module {
            single { configuration }

            single<AuthService> { AuthServiceImpl(get()) }

            single<UserService> {
                UserServiceImpl(database.getCollection(CollectionInfo.USER.collectionName))
            }

            single<ProjectService> {
                ProjectServiceImpl(database.getCollection(CollectionInfo.PROJECT.collectionName))
            }

            single<TagService> {
                TagServiceImpl(database.getCollection(CollectionInfo.TAG.collectionName))
            }

            single<TaskService> {
                TaskServiceImpl(database.getCollection(CollectionInfo.TASK.collectionName))
            }

            single<WorkService> {
                WorkServiceImpl(database.getCollection(CollectionInfo.WORK.collectionName))
            }

            single<CommentService> {
                CommentServiceImpl(database.getCollection(CollectionInfo.COMMENT.collectionName))
            }

            single<NoteService> {
                NoteServiceImpl(database.getCollection(CollectionInfo.NOTE.collectionName))
            }

            single<AttachmentService> {
                AttachmentServiceImpl(database.getCollection(CollectionInfo.ATTACHMENT.collectionName))
            }

            single<S3Service> { S3ServiceImpl(get()) }
            single<FileService> { FileServiceImpl() }

            single { MiddlewareContainer(get(), get(), get(), get(), get(), get(), get()) }

            single { TaskMapper(get(), get(), get()) }
            single { NoteMapper(get()) }
            single { CommentMapper(get()) }
            single { WorkMapper(get()) }

            single { MainController() }
            single { AuthController(get(), get()) }
            single { UserController(get(), get(), get(), get()) }
            single { ProjectController(get(), get(), get(), get(), get()) }
            single { TagController(get(), get()) }
            single { WorkController(get(), get(), get()) }
            single { CommentController(get(), get(), get()) }
            single { NoteController(get(), get(), get()) }
            single { AttachmentController(get(), get()) }

            single {
                TaskController(
                    get(),
                    get(),
                    get(),
                    get(),
                    get(),
                    get(),
                    get(),
                    get(),
                    get(),
                    get(),
                    get()
                )
            }
        }
    }
}