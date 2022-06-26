import { DataSourceOptions } from 'typeorm';
import { LOCAL_DATABASE_URL } from '../constants/common';
import { Todo } from '../models/todo';

export const dbConfig: DataSourceOptions = {
  type: 'postgres',
  url: process.env.DATABASE_URL || LOCAL_DATABASE_URL,
  entities: [Todo],
  synchronize: true,
};
