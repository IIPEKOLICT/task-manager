import { Tag, Todo, Topic } from '../models';
import { TagDto, TodoDto, TopicDto } from './dtos';

export interface IBaseService<M> {
  getAll(): Promise<M[]>;
  getOne(id: number): Promise<M>;
  delete(id: number): Promise<number>;
}

export interface ITodoService extends IBaseService<Todo> {
  getByTopic(topic: Topic): Promise<Todo[]>;
  create(topic: Topic, tags: Tag[], dto: Partial<TodoDto>): Promise<Todo>;
  change(id: number, topic: Topic, tags: Tag[], dto: Partial<TodoDto>): Promise<Todo>;
  removeTag(tagId: number): Promise<Todo[]>;
  removeTagsFromTodo(todoId: number): Promise<Todo>;
}

export interface ITagService extends IBaseService<Tag> {
  getByIds(ids?: number[]): Promise<Tag[]>;
  create(dto: Partial<TagDto>): Promise<Tag>;
  change(id: number, dto: Partial<TagDto>): Promise<Tag>;
}

export interface ITopicService extends IBaseService<Topic> {
  create(dto: Partial<TopicDto>): Promise<Topic>;
  change(id: number, dto: Partial<TopicDto>): Promise<Topic>;
}
