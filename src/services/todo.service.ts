import { BaseService } from '../core/base.service';
import { Todo } from '../models';
import { ITodoService } from '../abstractions/interfaces';
import { TodoDto } from '../abstractions/dtos';
import { Tag, Topic } from '../models';
import { updateEntityFields } from '../shared/utils';
import { UPDATE_TODO_FIELDS } from '../constants/common';

export class TodoService extends BaseService<Todo> implements ITodoService {
  async getByTopic(topic: Topic): Promise<Todo[]> {
    return this.repository.findBy({ topic });
  }

  async create(topic: Topic, tags: Tag[], dto: Partial<TodoDto>): Promise<Todo> {
    const { text, header, priority, isCompleted } = dto;

    return this.repository.save(
      this.repository.create({ text, header, priority, isCompleted, topic, tags }),
    );
  }

  async change(id: number, topic: Topic, tags: Tag[], dto: Partial<TodoDto>): Promise<Todo> {
    const todo: Todo = await this.removeTagsFromTodo(id);

    todo.topic = topic;
    todo.tags = tags;

    await this.repository.save(updateEntityFields(todo, dto, UPDATE_TODO_FIELDS));
    return todo;
  }

  async removeTag(tagId: number): Promise<Todo[]> {
    const todos: Todo[] = (await this.getAll()).map((todo: Todo) => {
      todo.tags = todo.tags.filter(({ id }) => id !== tagId);
      return todo;
    });

    return this.repository.save(todos);
  }

  async removeTagsFromTodo(todoId: number): Promise<Todo> {
    const todo: Todo = await this.getOne(todoId);

    todo.tags = [];
    await this.repository.save(todo);

    return todo;
  }
}
