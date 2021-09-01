import React, { useCallback } from 'react';
import { Link, Route, RouteComponentProps, Switch, useRouteMatch } from 'react-router-dom';
import classNames from 'classnames';
import { NotificationPrefs } from './preferences/NotificationPrefs';
import { SystemUpdatePrefs } from './preferences/SystemUpdatePrefs';
import notificationsSVG from '../assets/notifications.svg';
import systemUpdatesSVG from '../assets/system-updates.svg';

export const SystemPreferences = ({ match }: RouteComponentProps<{ submenu: string }>) => {
  const subMatch = useRouteMatch<{ submenu: string }>(`${match.url}/:submenu`);

  const matchSub = useCallback(
    (target: string) => {
      if (!subMatch && target === 'notifications') {
        return true;
      }

      return subMatch?.params.submenu === target;
    },
    [match, subMatch]
  );

  return (
    <div className="flex h-[600px] max-h-full">
      <aside className="flex-none min-w-60 border-r-2 border-gray-50">
        <div className="p-5">
          <input className="input h4 default-ring bg-gray-50" placeholder="Search Preferences" />
        </div>
        <nav className="border-b-2 border-gray-50">
          <ul className="font-semibold">
            <li>
              <Link
                to={`${match.url}/notifications`}
                className={classNames(
                  'flex items-center px-5 py-3 hover:text-black hover:bg-gray-50',
                  matchSub('notifications') && 'text-black bg-gray-50'
                )}
              >
                <img className="w-8 h-8 mr-3" src={notificationsSVG} alt="" />
                Notifications
              </Link>
            </li>
            <li>
              <Link
                to={`${match.url}/system-updates`}
                className={classNames(
                  'flex items-center px-5 py-3 hover:text-black hover:bg-gray-50',
                  matchSub('system-updates') && 'text-black bg-gray-50'
                )}
              >
                <img className="w-8 h-8 mr-3" src={systemUpdatesSVG} alt="" />
                System Updates
              </Link>
            </li>
          </ul>
        </nav>
      </aside>
      <section className="flex-1 px-5 py-7 text-black">
        <Switch>
          <Route path={`${match.url}/system-updates`} component={SystemUpdatePrefs} />
          <Route path={[`${match.url}/notifications`, match.url]} component={NotificationPrefs} />
        </Switch>
      </section>
    </div>
  );
};
