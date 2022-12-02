package taskmanager.backend.plugins.annotations

import taskmanager.backend.enums.EditableEntity

@Retention(AnnotationRetention.RUNTIME)
@Target(AnnotationTarget.FUNCTION)
annotation class EditAccess(val entity: EditableEntity, val message: String = "")
