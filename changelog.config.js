'use strict';

module.exports = {
  disableEmoji: false,
  format: '{type}({scope}): {subject}',
  list: ['feat', 'fix', 'chore', 'docs'],
  maxMessageLength: 64,
  minMessageLength: 3,
  questions: ['type', 'scope', 'subject'],
  scopes: [
    'ghostty',
    'lazygit',
    'nvim',
    'raycast',
    'ssh',
    'yazi',
    'zellij',
    'hammerspoon',
    'brew',
    'setup',
  ],
  types: {
    feat: {
      description: '設定の追加・更新',
      emoji: '✨',
      value: 'feat',
    },
    fix: {
      description: '設定の修正',
      emoji: '🐛',
      value: 'fix',
    },
    chore: {
      description: 'その他の変更',
      emoji: '🔧',
      value: 'chore',
    },
    docs: {
      description: 'ドキュメントの更新',
      emoji: '📚',
      value: 'docs',
    },
  },
};
