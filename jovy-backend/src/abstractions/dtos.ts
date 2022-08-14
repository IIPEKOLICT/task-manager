import { Priority } from '../constants/enums';

export type IterableDto = {
  [field: string]: any;
};

export type DeleteDto = {
  readonly id: number;
};

export type TodoDto = IterableDto & {
  readonly topic: number;
  readonly tags: number[];
  readonly header: string;
  readonly text: string;
  readonly priority: Priority;
  readonly isCompleted: boolean;
};

export type TagDto = IterableDto & {
  readonly name: string;
  readonly color: string;
};

export type TopicDto = IterableDto & {
  readonly name: string;
  readonly description: string;
};
