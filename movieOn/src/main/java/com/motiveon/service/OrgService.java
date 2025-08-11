package com.motiveon.service;

import java.util.List;
import java.util.Map;

public interface OrgService {
	java.util.List<java.util.Map<String, Object>> getOrgTree();

	List<Map<String, Object>> getChildren(String parent);

	Long createDepartment(String name, String parent);

	void renameNode(String id, String name);

	void deleteNode(String id);

	  void moveNode(String id, String parent, int pos, String oldParent);

}
