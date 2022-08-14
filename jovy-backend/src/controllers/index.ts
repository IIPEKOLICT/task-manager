import { ControllerClass } from 'jovy';
import { TodoController } from './todo.controller';
import { TopicController } from './topic.controller';
import { TagController } from './tag.controller';

export const controllers: ControllerClass[] = [TodoController, TopicController, TagController];
