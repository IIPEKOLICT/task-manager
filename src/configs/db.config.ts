import { DataSourceOptions } from 'typeorm';
import { LOCAL_DATABASE_URL } from '../constants/common';
import { Tag, Todo, Topic } from '../models';

export const dbConfig: DataSourceOptions = {
  type: 'postgres',
  url: process.env.DATABASE_URL || LOCAL_DATABASE_URL,
  entities: [Todo, Tag, Topic],
  synchronize: true,
};
