import { DataSource } from 'typeorm';
import { dbConfig } from '../configs/db.config';

export const db: DataSource = new DataSource(dbConfig);
