import 'reflect-metadata';
import { App, AppConfiguration, Application, config } from 'jovy';
import { controllers } from './controllers';
import { db } from './shared/db';

config();

const appConfig: AppConfiguration = {
  port: process.env.PORT,
  controllers,
};

new App(appConfig).launch(async (app: Application, port: string | number) => {
  try {
    await db.initialize();
    console.log(`Successfully connected to database`);
    app.listen(port, () => console.log(`Server started on ${port} port`));
  } catch (error) {
    console.error(error);
  }
});
